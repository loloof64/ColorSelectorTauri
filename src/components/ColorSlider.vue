<template>
  <div class="color_slider">
    <input
      type="range"
      min="0"
      max="255"
      :value="colorValue"
      @input="handleControlEvent"
    />
    <input
      type="number"
      :value="colorValue"
      min="0"
      max="255"
      @change="handleControlEvent"
    />
    <div :style="{ 'background-color': previewColor }" class="preview"></div>
  </div>
</template>

<script>
import { ref } from "vue";
export default {
  props: {
    red: {
      type: Boolean,
      default: false,
    },
    green: {
      type: Boolean,
      default: false,
    },
    blue: {
      type: Boolean,
      default: false,
    },
  },
  setup(props, {emit}) {
    function colorsToHexa({ red, green, blue }) {
      let redHexa = red.toString(16);
      if (redHexa.length < 2) redHexa = "0" + redHexa;
      let greenHexa = green.toString(16);
      if (greenHexa.length < 2) greenHexa = "0" + greenHexa;
      let blueHexa = blue.toString(16);
      if (blueHexa.length < 2) blueHexa = "0" + blueHexa;

      return `#${redHexa}${greenHexa}${blueHexa}`;
    }

    const colorValue = ref(0);
    const previewColor = ref(colorsToHexa({ red: 0, green: 0, blue: 0 }));

    function updateControls(newValue) {
      if (newValue < 0) return;
      if (newValue > 255) return;

      colorValue.value = newValue;
      previewColor.value = colorsToHexa({
        red: props.red ? newValue : 0,
        green: props.green ? newValue : 0,
        blue: props.blue ? newValue : 0,
      });

      emit('changed', newValue);
    }

    function handleControlEvent(evt) {
      const newValue = parseInt(evt.target.value, 10);
      updateControls(newValue);
    }

    return {
      updateControls,
      colorValue,
      previewColor,
      handleControlEvent,
    };
  },
};
</script>

<style scoped>
.color_slider {
  display: flex;
  flex-direction: row;
  justify-content: space-around;
  align-self: center;
}
.color_slider > * {
  margin: 10px;
}

.preview {
  width: 100px;
  height: 30px;
}
</style>