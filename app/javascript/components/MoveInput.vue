<template>
  <div class="row">
    <div v-for="(valid, column) in validMoves" :key="column" class="num">
        <button @click="$emit('move', column)" :disabled="!valid" class="button">{{ column }}</button>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  props: {
    moves: {
      type: Array,
      required: true,
      validator: function(moves) {
        return moves.reduce(function(valid, move) {
          return valid && !isNaN(move) && move >= 0 && move <= 6;
        }, true);
      }
    },
    movesAllowed: {
      type: Boolean,
      required: true
    },
    gameResult: {
      type: String,
      required: true,
      validator: function(gameResult) {
        return (
          gameResult == "1" ||
          gameResult == "2" ||
          gameResult == "tie" ||
          gameResult == "incomplete"
        );
      }
    },
    currentPlayerType: {
      type: String,
      required: true,
      validator: function(playerType) {
        return playerType == "human" || playerType == "computer";
      }
    }
  },
  computed: {
    validMoves: function() {
      if (
        this.currentPlayerType == "human" &&
        this.movesAllowed &&
        this.gameResult == "incomplete"
      ) {
        let validMoves = [];
        for (let candidateMove = 0; candidateMove < 7; candidateMove++) {
          let priorMoveCount = 0;
          for (let i = 0; i < this.moves.length; i++) {
            if (this.moves[i] == candidateMove) {
              priorMoveCount++;
            }
          }
          validMoves.push(priorMoveCount < 6);
        }
        return validMoves;
      } else {
        return [false, false, false, false, false, false, false];
      }
    }
  }
};
</script>

<style scoped>
.num {
  width: 96px;
  display: inline-block;
  margin-bottom: 15px;
}

.button {
  font-size: 18px;
  width: 50px;
  background-color: #6ed8b7;
  color: white;
  border: none;
  box-shadow: 2px 2px #60a590;
  border-radius: 10%;
}

.row {
  width: 700px;
  margin: -3px auto;
  padding: 0;
}
</style>
