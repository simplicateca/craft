<template>
    <div class="c-modal"
        :class="{ active: content != '' }"
        :tabindex="open ? 0 : -1"
        @keydown.esc="closeModal"
        >
        <div class="overlay" v-on:click.prevent="closeModal"></div>
        <div class="outer">
            <div class="scroller" ref="modalContent" tabindex="0">
                <div class="wrapper">
                    <div class="content">
                        <div v-html="content"></div>
                    </div>
                </div>
            </div>
            <a href="#" class="close" aria-label="Close Window" v-on:click.prevent="closeModal" :tabindex="open ? 0 : -1"></a>
        </div>
    </div>
</template>

<script>
    import axios from 'axios'

    export default {
        data() {
            return {
                ajaxContent: '',
                content: '',
                open: false,
                previousFocus: null,
                forceHistoryRefresh: false,
            }
        },

        props: {
            link: {
                type: String,
                default: ''
            },
        },

        mounted() {
            
        },

        methods: {
            closeModal(event) {
                if( this.open ) {
                    this.hideModal()
                    window.history.back()
                }

            },

            hideModal() {
                var links = document.querySelectorAll('body a, *[role=button], button, input, select, textarea')
                links.forEach(function(val,index) {
                    val.setAttribute('tabindex', 0)
                })

                if( document.documentElement.classList.contains('user-is-tabbing') && this.previousFocus != null ) {
                    this.previousFocus.focus()
                }
               
                document.body.classList.remove("noscroll")

                this.open = false
                this.content = ''
                this.ajaxContent = ''
                this.previousFocus = null

                this.$emit('close')
            },

            pageStateHistory(event) {
                if( event.state && event.state.type == 'modal' ) {
                    this.content = event.state.content
                    this.open = true
                } else {
                    this.hideModal()
                    if( this.forceHistoryRefresh ) {
                        window.location.replace( window.location.href )
                    }
                }
            }
        },

        watch: {
            link( newValue, oldValue ) {
                if( newValue == '' && newValue != oldValue ) {
                    this.hideModal()
                } else {
                    axios
                        .get(newValue, {headers: {'X-Requested-With': 'XMLHttpRequest'}} )
                        .then(response => ( this.ajaxContent = response.data ))
                        .catch( function(error) {
                            window.location.replace( window.location.href )
                        })
                }
            },

            ajaxContent( newValue, oldValue ) {
                if( newValue != '' ) {

                    this.content = newValue

                    if( document.documentElement.classList.contains('user-is-tabbing') ) {
                        this.previousFocus = document.activeElement;
                    }

                    var links = document.querySelectorAll('body a, *[role=button], button, input, select, textarea')
                    links.forEach(function(val,index) {
                        val.setAttribute('tabindex', -1)
                    })

                    document.body.classList.add("noscroll")
                    this.open = true

                    history.pushState( {
                        type: 'modal',
                        content : newValue,
                        url: this.link
                    }, null, this.link )

                    if( document.documentElement.classList.contains('user-is-tabbing') ) {
                        this.$refs.modalContent.focus()
                    }
                }
            }
        },

        created() {
            window.addEventListener("popstate", this.pageStateHistory);

            // this occurs when we click from a modal to another page and
            // then try to come "back" to the modal, but end up on the proper
            // url for the content that the modal was framing.
            if( history.state != null && history.state.type == 'modal' && !this.open ) {
                this.forceHistoryRefresh = true
            }

            if( history.scrollRestoration ) {
                history.scrollRestoration = 'manual';
            }
        },

        beforeDestroy () {
            window.removeEventListener("popstate", this.pageStateHistory);
        }
    }
</script>

<style scoped>
    .c-modal {
        position: fixed;
        top: 0;
        left: 0;
        width: 0;
        height: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        opacity: 0;
        z-index: -1;
        transition: opacity 0.15s linear;

        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 0;
            height: 0;            
            background: rgba(0,0,0,0.75);
            z-index: -1;
        }

        &.active {
            opacity: 1;
            z-index: 10000;
            width: 100vw;
            height: 100vh;

            .overlay {
                z-index: 10001;
                width: 100vw;
                height: 100vh;
            }

            .outer {
                opacity : 1;
                width: 700px;
                height: 72vh;                
                transform: translateY(0px);
                transition: opacity 0.3s linear 0.3s,
                            transform 0.2s ease-in-out 0.25s;
            }
        }

        .outer {
            position: absolute;
            background: #fff;
            padding: 0px;
            height: 0;
            width: 0;
            z-index: 10002;  
            opacity: 0;
            transform: translateY(50px);
            transition: all 0s;
            max-width: 95vw;
        }

        .scroller {
            overflow: auto;
            height: 100%;
        }

        .wrapper {
            position : relative;

            .content {
                height: 100%;
                padding: 0 2rem;
            }
        }

        .close {
            position: absolute;
            right: -40px;
            top: -40px;
            width: 32px;
            height: 32px;
            opacity: 0.8;
            z-index: 100000;

            &:hover {
                opacity: 1;
            }

            &:before, &:after {
                position: absolute;
                left: 15px;
                content: '';
                height: 33px;
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