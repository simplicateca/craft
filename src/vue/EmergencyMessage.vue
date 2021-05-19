<template>
    <div class="emergency-message" :class="{ hidden: !showing }">
        <p>
            {{msg.text}}
            <a v-if="msg.url" :href="msg.url">{{msg.link || 'Details'}}</a>
        </p>
        <a href="#" class="close" aria-label="Close Notification" v-on:click.prevent="close"></a>
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
            close() {
                this.showing = false
                document.body.classList.remove('has-emergency-message')
                $cookies.set('hideEMsg', true )
            },
        }
    }
</script>

<style scoped>
    .emergency-message {
        background: #000;
        display: flex;
        max-height: 60px;
        align-items: center;
        justify-content: center;
        overflow: hidden;
        transition: all 0.15s linear;
        position: relative;
        z-index: 9999;
        padding: 0 1rem;
        
        p {
            margin: 0;
            padding: 20px 0;
            font-weight: bold;
            color: #fff;
            text-align : center;
            flex-grow: 1;

            &:before {
                content: '';
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
        }

        body.scrolled & {
            max-height: 0;
        }

        &.hidden {
            max-height: 0 !important;
            opacity: 0;
        }

        .close {
            position: relative;
            /* right: 22px;
            top: 18px; */
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