<template>
  <div class="centered">
    <label for="search-depth-selector">Select difficulty:</label>
    <select
      id="search-depth-selector"
      @change="setSearchDepth">
      <template v-for="depth in [1,2,3,4,5]">
        <template v-if="depth == searchDepth">
          <option :key="depth" selected>{{ depth }}</option>
        </template>
        <template v-else>
          <option :key="depth">{{ depth }}</option>
        </template>
      </template>
    </select>
  </div>
</template>

<script>
export default {
  props: {
    searchDepth: {
      type: Number,
      required: true,
      validator: function(value) {
        return value >= 1 || value <= 5;
      }
    }
  },
  methods: {
    setSearchDepth(e) {
      this.$emit("setSearchDepth", parseInt(e.target.value));
    }
  }
};
</script>

<style scoped>
</style>
