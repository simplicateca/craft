<template>
    <div class="emergency-message" :class="{ hidden: !showing }">
        <div v-html="msg.text"></div>
        <a v-if="msg.url" :href="msg.url" v-on:click.prevent="onCTA">{{msg.link || 'Details'}}</a>
        <a href="#" class="close" aria-label="Close Notification" v-on:click.prevent="onClose"></a>
    </div>
</template>

<script>
    import Vue from 'vue'
    import VueCookies from 'vue-cookies'
    Vue.use(VueCookies)

    export default {
        components: {},
        
        data() {
            return {
                showing: false
            }
        },

        props: {
            msg: {
                type: Object,
                default: function() { return {} }
            }
        },

        mounted() {
            if( !$cookies.get('hideEMsg') ) {
                this.showing = true
                document.body.classList.add('has-emergency-message')
            }
        },

        methods: {
            onCTA() {
                $cookies.set('hideEMsg', true )
                window.location.href = this.msg.url
            },

            onClose() {
                this.showing = false
                document.body.classList.remove('has-emergency-message')
                $cookies.set('hideEMsg', true )
            },
        }
    }
</script>

<style>
    #emergency-message {
        position: sticky;
        top: 0;
        width: 100%;
        z-index: 10000;
    }

    .emergency-message {
        background: #000;
        display: flex;
        align-items: center;
        justify-content: center;
        overflow: hidden;
        position: relative;
        z-index: 9999;
        padding: 0 1rem;
        min-height: 40px;
        max-height: 40px;
        transition: max-height 0.15s linear, opacity 0.15s linear;
               
        p {
            margin: 0;
            padding: 0px 0;
            font-weight: bold;
            color: #fff;
            text-align : center;
            flex-grow: 1;
            font-size: 1.5rem;

            &:before {
                content: '';
            }
        }

        a {
            color: var(--blonde);
            display: inline-block;
            margin-left: 2px;

            &:focus,
            &:hover {
                color: var(--red);
            }

            &::after {
                content: '›';
                display: inline-block;
                margin-left: 3px;
            }
        }

        &.hidden {
            min-height: 0 !important;
            max-height: 0 !important;
            opacity: 0;
        }

        .close {
            position: relative;
            width: 22px;
            height: 22px;
            opacity: 0.8;
            z-index: 100000;

            &:focus,
            &:hover {
                opacity: 1;

                &:before, &:after {
                    background-color: var(--red);
                }

            }

            &:before, &:after {
                position: absolute;
                left: 9px;
                content: '';
                height: 22px;
                width: 4px;
                background-color: #fff;
                z-index: 1000;
            }

            &:before {
                transform: rotate(45deg);
            }
            &:after {
                transform: rotate(-45deg);
            }
        }
    }
</style>