<template>
  <div class="centered">
    <button @click="$emit('resetGame')">Reset</button>
  </div>
</template>

<script>

export default {
  methods: {
    resetGame () {
      this.$emit('resetGame')
    }
  }
}
</script>

<style scoped>
.centered {
  text-align: center;
}
</style>
