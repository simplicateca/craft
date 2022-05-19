<template>
    <div class="c-mobileMenu">
        <nav v-if="open" class="bg-stone-900">
            <div class="flex w-full items-center sticky top-0 bg-stone-900 p-4 text-white">
                <div class="c-primaryLogo flex-grow">
                    <a href="/" class="text-white">[LOGO]</a>
                </div>

                <mobile-toggle :open="true"></mobile-toggle>
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
    import MobileToggle from './MobileToggle'

    export default {
        components: {
            'mobile-toggle': MobileToggle
        },

        data() {
            return {
                
            }
        },

        props: {
            pages: {
                type: Array,
                default: []
            },

            open: {
                type: Boolean,
                default: false
            }
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

            here(event) {
                console.log(event)
            },

            menuOn(menu) {
                //this.showMenu[menu] = true;
            },

            menuOff(menu) {
                //this.showMenu[menu]  = false;
            },

            showSub( pageid ) {
                //this.openMenu = ( this.openMenu == pageid ) ? 0 : pageid
            }
        }
   }
</script>