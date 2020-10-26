<template>
    <div class="c-mobileMenu">
        <a href="#" class="toggle" @click.prevent="toggleMenu" :class="mobileMenuOpen ? 'active' : ''">
            <span></span>
            <span></span>
            <span></span>
        </a>

        <nav v-if="mobileMenuOpen">
            <div class="logo">
                <div class="c-primaryLogo">
                    <a href="/">[LOGO]</a>
                </div>
            </div>

            <div class="menuWrapper">
                <div class="menu">
                    <ul class="primary">
                        <li v-for="page in pageTree" :key="page.id">
                            <a :href="page.url" class="menu">{{ page.title }}</a>
                            <ul class="second" v-if="page.children">
                                <li v-for="child in page.children" :key="child.id">
                                    <a :href="child.url">{{ child.title }}</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                mobileMenuOpen: false,
                openMenu: 0
            }
        },

        props: {
            pages: {
                type: Array,
                default: []
            },
        },

        computed: {
            pageTree() {
                return this.createTree( this.pages );
            }
        },

        methods : {
            createTree(array) {
                let a = array
                let result = []
                let levels = [{ children: result }]

                a.forEach(function (o) {
                    let thisLevel = o.level - 1
                    levels[thisLevel].children = levels[thisLevel].children || [];
                    levels[thisLevel].children.push(levels[thisLevel + 1] = o);
                });

                return result;
            },

            toggleMenu( status = '' ) {
                if( status  == 'off' ) {
                    this.mobileMenuOpen = false;
                } else {
                    this.mobileMenuOpen = !this.mobileMenuOpen;
                }

                if( this.mobileMenuOpen ) {
                    document.querySelector('body').classList.add('has-mobile-menu');
                } else {
                    document.querySelector('body').classList.remove('has-mobile-menu');
                }
            },

            menuOn(menu) {
                this.showMenu[menu] = true;
            },

            menuOff(menu) {
                if( menu == 'all' ) {
                    this.toggleMenu( 'off' )
                } else {
                    this.showMenu[menu]  = false;
                }
            },

            showSub( pageid ) {
                this.openMenu = ( this.openMenu == pageid ) ? 0 : pageid
            }
        }
   }
</script>

<style lang="scss" scoped>

    @keyframes menuIn {
        from {opacity: 0;}
        to {opacity: 1;}
    }

    .c-mobileMenu {
        position: relative;
        z-index: 100000;

        .c-primaryLogo {
            margin-left: 1rem;
            padding-top: 1rem;
            
            a {
                color: #fff;
            }
        }

        nav {
            display: flex;
            flex-direction: column;
            opacity: 0;
            max-height: 0px;
            z-index: 1000;
            position: fixed;
            overflow: auto;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--dark);
            animation-name: menuIn;
            animation-duration: 0.5s;
            animation-fill-mode: forwards;

            @include tablet-down {
                min-height: 100vh;
                max-height: auto;
            }

            .logo {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                background: var(--dark);
                height: 60px;
                z-index: 5;
            }

            .menuWrapper {
                display: flex;
                min-height: 100%;
                justify-content: center;
                flex-grow: 1;
                padding-top: 25vh;
            }

            ul.primary {
                display: flex;
                flex-direction: column;
                align-items: center;

                & > li {
                    margin-bottom: 2rem;
                    text-align: center;

                    &:last-of-type {
                        margin-bottom: 5em;
                    }

                    a {
                        font-size: 3rem;
                        display: block;
                        text-decoration: none;
                        color: #fff;
                    }
                }
            }

            ul.second {
                display: flex;
                flex-wrap: wrap;
                align-items: center;

                li {
                    margin: 1.5rem 1rem;
                    
                    a {
                        display: block;
                        font-size: 2rem;
                        color: #fff;
                        text-decoration: none;
                    }
                }
            }
        }

        .toggle {
            display : none;
            z-index: 1001;

            @include tablet-down {
                top       : 15px;
                display   : block;
                position  : fixed;
                right     : 20px;
                height    : 24px;
                width     : 30px;
                transform : translateY(0px);
                transition: transform 0.3s;

                body.has-emergency-message & {
                    transform: translateY(60px);
                }
            }

            @include tiny {
                right: 10px;
            }

            span {
                height          : 4px;
                width           : 30px;
                position        : absolute;
                left            : 0;
                top             : 0;
                background-color: var(--dark);
                transition      : transform 0.3s ease-in-out, background-color 0.3s ease-in-out;

                &:nth-child(1) {
                    body.has-mobile-menu & {
                        background-color: transparent;
                    }
                }

                &:nth-child(2) {
                    top: calc( 50% - 2px );

                    body.has-mobile-menu & {
                        top   : 10px;
                        transform: rotate(-45deg);
                        background-color: #fff;
                    }
                }

                &:nth-child(3) {
                    bottom: 0;
                    top   : auto;

                    body.has-mobile-menu & {
                        background-color: #fff;
                        transform: rotate(45deg);
                        bottom: auto;
                        top   : 10px;
                    }
                }
            }
        }
    }
</style>
