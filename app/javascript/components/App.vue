<template>
  <div>
    <h1 class="centered">Connect 4</h1>
    <h3 class="centered">IA - Proyecto 1</h3>
    <div class="player-selector-container">
      <PlayerSelector
        :player=1
        :playerType="playerOneType"
        @setPlayerType="setPlayerType" />
      <PlayerSelector
        :player=2
        :playerType="playerTwoType"
        @setPlayerType="setPlayerType" />
    </div>
    <br/>
    <SearchDepthSelector
      :searchDepth="searchDepth"
      @setSearchDepth="setSearchDepth"/>
    <br/>
    <div class="centered">Player to move: {{ playerToMove }}</div>
    <MoveInput
      :moves=moves
      :movesAllowed=movesAllowed
      :gameResult=gameResult
      :currentPlayerType=currentPlayerType
      @move="move" />
    <GameBoard
      :moves=moves />
    <GameResult
      :gameResult=gameResult /><br/>
    <ResetButton
      @resetGame=resetGame />
    <h2>Instructions</h2>
    <ul>
      <li>Select player type</li>
      <li>Select difficulty level</li>
      <li>When playing as a human, click one of the buttons labed "1" through "5" to select a column for your move.</li>
    </ul>
    <p>Click the "Reset" button at any time to clear the game board and start over.</p>
    <p>The difficulty level represents the search depth, which determines how many moves into the future the computer should look before picking a move. Higher search depths make the computer a more difficult opponent.</p>
  </div>
</template>

<script>
import axios from "axios";
import PlayerSelector from "./PlayerSelector.vue";
import GameBoard from "./GameBoard.vue";
import MoveInput from "./MoveInput.vue";
import ResetButton from "./ResetButton.vue";
import GameResult from "./GameResult.vue";
import SearchDepthSelector from "./SearchDepthSelector.vue";

export default {
  components: {
    PlayerSelector,
    GameBoard,
    MoveInput,
    ResetButton,
    GameResult,
    SearchDepthSelector
  },
  data() {
    return {
      moves: [],
      playerOneType: "human",
      playerTwoType: "human",
      playerToMove: 1,
      gameResult: "incomplete",
      movesAllowed: true,
      searchDepth: 3
    };
  },
  updated: function() {
    if (this.movesAllowed && this.gameResult == "incomplete") {
      if (this.currentPlayerType == "computer") {
        this.movesAllowed = false;
        const computerMoveUrl =
          "/games/computer_move.json?moves=" +
          this.moves.toString() +
          "&depth=" +
          this.searchDepth;
        axios.get(computerMoveUrl).then(response => {
          if (this.arraysAreEqual(this.moves, response.data.moves)) {
            this.move(response.data.computer_move);
          }
        });
      }
    }
  },
  computed: {
    currentPlayerType: function() {
      if (this.playerToMove == 1) {
        return this.playerOneType;
      } else {
        return this.playerTwoType;
      }
    }
  },
  methods: {
    setSearchDepth: function(searchDepth) {
      this.searchDepth = searchDepth;
    },
    move: function(move_column) {
      this.moves.push(move_column);
      this.playerToMove = this.playerToMove == 1 ? 2 : 1;
      const gameResultUrl =
        "/games/game_result.json?moves=" + this.moves.toString();
      this.movesAllowed = false;
      axios.get(gameResultUrl).then(response => {
        this.gameResult = response.data.game_result;
        if (this.gameResult == "incomplete") {
          this.movesAllowed = true;
        }
      });
    },
    resetGame: function() {
      this.moves = [];
      this.playerToMove = 1;
      this.gameResult = "incomplete";
      this.movesAllowed = true;
    },
    setPlayerType: function(player, type) {
      if (player == 1) {
        this.playerOneType = type;
      } else if (player == 2) {
        this.playerTwoType = type;
      }
    },
    arraysAreEqual: function(arrayA, arrayB) {
      if (arrayA.length != arrayB.length) {
        return false;
      }
      for (let i = 0; i < arrayA.length; i++) {
        if (arrayA[i] != arrayB[i]) {
          return false;
        }
      }
      return true;
    }
  }
};
</script>

<style scoped>
.centered {
  text-align: center;
}
.player-selector-container {
  justify-content: space-around;
  display: flex;
}
</style>
