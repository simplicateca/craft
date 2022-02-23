// App main
const main = async() => {
    // Async load the vue module
    const { default: Vue } = await import(/* webpackChunkName: "vue" */ 'vue');
    
    // load the vue waypoint
    const { default: VueWaypoint } = await import(/* webpackChunkName: "vuewaypoint" */ 'vue-waypoint');
    Vue.use(VueWaypoint)

    // hooper slider
    const { Hooper, Slide, Pagination } = await import(/* webpackChunkName: "hooper" */ 'hooper');

    // Create our vue instance
    const vm = new Vue({
        el: "#content-container",
        components: {
            'modal': () => import(/* webpackChunkName: "modal" */ '@/vue/Modal.vue'),
            Hooper,
            Slide,
            HooperPagination: Pagination
        },
        data: function() {
            return {
                currentAccordion: false,
                modalLink : '',
                intersectionOptions: {
                    threshold: [0.25]
                }
            };
        },

        methods: {
            onWaypoint({ el, going, direction }) {
                if( this.$waypointMap.GOING_IN === going ) {
                    el.classList.add('active')
                }
            },

            loadModal(event) {
                var isIE11 = !!window.MSInputMethodContext && !!document.documentMode;
                if( event.target.href ) {
                    this.modalLink = event.target.href
                }
                else if( event.target.closest('a') ) {
                    if( isIE11 ) {
                        window.location.href = event.target.closest('a').href
                    } else {
                        this.modalLink = event.target.closest('a').href
                    }
                }
            },

            loadImage( blockRef, imgSrc, imgTitle ) {
                this.$refs['gallery'+blockRef].src = imgSrc;
                this.$refs['gallery'+blockRef].setAttribute("alt", imgTitle);
            },

            onModalClose() {
                this.modalLink = ''
            },

            openAccordion(rowID, slug) {
                if( this.currentAccordion == rowID ) {
                    document.querySelector('#ar'+rowID).style.height=0
                    this.currentAccordion = false
                    history.replaceState( null, null, '#' )
                } else {

                    if( this.currentAccordion ) {
                        document.querySelector('#ar'+this.currentAccordion).style.height=0
                    }

                    this.currentAccordion = rowID
                    document.querySelector('#ar'+rowID).style.height = document.querySelector('#ar'+rowID).scrollHeight + 'px';
                    history.replaceState( null, null, '#ai'+rowID + '-' + slug )
                }
            },

            openTab(rowID, slug, blockID) {
                document.querySelectorAll('.tab__selector.block'+blockID).forEach(function(tabContent) {
                    tabContent.classList.remove('active')
                })

                document.querySelectorAll('.tab__content.block'+blockID).forEach(function(tabContent) {
                    tabContent.style.display='none'
                })
                document.querySelector('#tabc'+rowID).style.display='block'
                document.querySelector('#tabs'+rowID).classList.add('active')
                
                //history.replaceState( null, null, '#ai'+rowID + '-' + slug )
            },

            scrollToID(id) {
                const yOffset = -100;
                const element = document.getElementById(id);
                const y = element.getBoundingClientRect().top + window.pageYOffset + yOffset;

                window.scrollTo({top: y, behavior: 'smooth'});
            }
        },

        mounted() {
            let match = window.location.hash.match(/^#ai(\d+).*?/gi)
            if( match ) {
                let rowID = match[0].replace( '#ai', '' )
                let slug  = window.location.hash.replace( match[0] + '-', '' )
                this.openAccordion( rowID, slug )
                //this.scrollToID( 'ai'+rowID )
            } else {
                let match2 = window.location.hash.match(/^#([\w\-]+)/gi)
                if( match2 ) {
                    //this.scrollToID( match2[0].replace( '#', '' ) )
                }
            }
        },
    });
};

// Execute async function
main().then((value) => {
    
});
