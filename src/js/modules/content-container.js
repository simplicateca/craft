// App main
const main = async() => {
    // Async load the vue module
    const { default: Vue } = await import(/* webpackChunkName: "vue" */ 'vue');
    
    // load the vue waypoint
    const { default: VueWaypoint } = await import(/* webpackChunkName: "vuewaypoint" */ 'vue-waypoint');
    Vue.use(VueWaypoint)

    // Create our vue instance
    const vm = new Vue({
        el: "#content-container",
        components: {
            'modal': () => import(/* webpackChunkName: "modal" */ '@/vue/Modal.vue'),
        },
        data: function() {
            return {
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

            onModalClose() {
                this.modalLink = ''
            },
        },

        mounted() {

        },
    });
};

// Execute async function
main().then((value) => {
    
});
