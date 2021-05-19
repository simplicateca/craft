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