<template>
  <div class="centered">
    {{ gameResultString }}
  </div>
</template>

<script>

export default {
  props: {
    gameResult: {
      type: String,
      required: true,
      validator: function (gameResult) {
        return (gameResult == '1') || (gameResult == '2') || (gameResult == 'tie') || (gameResult == 'incomplete')
      }
    },
  },
  computed: {
    gameResultString: function () {
      if (this.gameResult == '1') {
        return "Player 1 wins!"
      } else if (this.gameResult == '2') {
        return "Player 2 wins!"
      } else if (this.gameResult == 'tie') {
        return "Tie game!"
      } else if (this.gameResult == 'incomplete') {
        return ""
      }
    }
  }
}
</script>

<style scoped>
.centered {
  text-align: center;
}
</style>
