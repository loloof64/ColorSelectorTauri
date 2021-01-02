<template>
  <div>
    <div class="preview">
      <div :style="{ 'background-color': previewColor }"></div>
    </div>
    <color-slider :red="true" @changed="updateRed" />
    <color-slider :green="true" @changed="updateGreen" />
    <color-slider :blue="true" @changed="updateBlue" />
  </div>
</template>

<script>
import { ref } from "vue";
import ColorSlider from "@/components/ColorSlider";
export default {
  name: "App",
  components: {
    ColorSlider,
  },
  setup() {
    const red = ref(0);
    const green = ref(0);
    const blue = ref(0);
    const previewColor = ref(colorsToHexa({ red: 0, green: 0, blue: 0 }));

    function colorsToHexa({ red, green, blue }) {
      let redHexa = red.toString(16);
      if (redHexa.length < 2) redHexa = "0" + redHexa;
      let greenHexa = green.toString(16);
      if (greenHexa.length < 2) greenHexa = "0" + greenHexa;
      let blueHexa = blue.toString(16);
      if (blueHexa.length < 2) blueHexa = "0" + blueHexa;

      return `#${redHexa}${greenHexa}${blueHexa}`;
    }

    function updatePreview() {
      previewColor.value = colorsToHexa({
        red: red.value,
        green: green.value,
        blue: blue.value,
      });
    }

    function updateRed(newValue) {
      red.value = parseInt(newValue);
      updatePreview();
    }

    function updateGreen(newValue) {
      green.value = parseInt(newValue);
      updatePreview();
    }

    function updateBlue(newValue) {
      blue.value = parseInt(newValue);
      updatePreview();
    }

    return {
      updateRed,
      updateGreen,
      updateBlue,
      previewColor,
    };
  },
};
</script>

<style scoped>
.preview {
  display: flex;
  justify-content: center;
  align-items: center;
}

.preview > div {
  width: 200px;
  height: 80px;
}
</style>
