<template>
  <div class="player-selector" v-bind:class="{
    'blue': player == 1,
    'red': player == 2
  }">
    <div>Player {{ player }} type:</div>
    <input
      type="radio"
      :id="humanId"
      @change="radioButtonClick"
      :name="groupName"
      value="human"
      checked>
    <label :for="humanId">Human</label><br/>

    <input
      type="radio"
      :id="computerId"
      @change="radioButtonClick"
      :name="groupName"
      value="computer">
    <label :for="computerId">Computer</label><br/>
    <br/>
  </div>
</template>

<script>
export default {
  props: {
    player: {
      type: Number,
      required: true,
      validator: function(value) {
        return value == 1 || value == 2;
      }
    },
    playerType: {
      type: String,
      required: true,
      validator: function(value) {
        return value == "human" || value == "computer";
      }
    }
  },
  methods: {
    radioButtonClick(e, l) {
      this.$emit("setPlayerType", this.player, e.target.value);
    }
  },
  computed: {
    groupName: function() {
      return "playerType" + this.player;
    },
    humanId: function() {
      return "player" + this.player.toString() + "human";
    },
    computerId: function() {
      return "player" + this.player.toString() + "computer";
    }
  }
};
</script>

<style scoped>
.red {
  color: red;
}

.blue {
  color: blue;
}
</style>
