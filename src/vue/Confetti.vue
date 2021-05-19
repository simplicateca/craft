<template>
    <div></div>
</template>

<script>
    import Vue from 'vue'
    import VueConfetti from 'vue-confetti'

    Vue.use(VueConfetti);

    export default {
        mounted: function() {
            this.$confetti.start({
                particles: [
                    { type: 'heart' },
                ],
                colors: ['DodgerBlue', 'OliveDrab', 'Gold', 'pink', 'SlateBlue', 'lightblue', 'Violet', 'PaleGreen', 'SteelBlue', 'SandyBrown', 'Chocolate', 'Crimson'],
            });
            setTimeout(() => {
                this.$confetti.stop();
            }, 5000);
        },
        methods: {}
    }
</script>

<style>
    #confetti-canvas {
        z-index: 1000;
    }
</style>true