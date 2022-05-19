<template>
    <a href="#" class="mobileMenuToggle" @click.prevent="toggle" :class="open ? 'active' : ''">
        <span></span>
        <span></span>
        <span></span>
    </a>
</template>

<script>
    export default {
        props: {
            open: {
                type: Boolean,
                default: false
            }
        },

        methods: {
            toggle() {
                this.$emit('toggle-menu')
                this.$parent.$emit('toggle-menu')
            }
        },
   }
</script>