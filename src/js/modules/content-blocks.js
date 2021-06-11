// App main
const main = async() => {
    // Async load the vue module
    const { default: Vue } = await import(/* webpackChunkName: "vue" */ 'vue');
    
    // load the vue waypoint
    const { default: VueWaypoint } = await import(/* webpackChunkName: "vuewaypoint" */ 'vue-waypoint');
    Vue.use(VueWaypoint)

    // Create our vue instance
    const vm = new Vue({
        el: "#block-container",
        components: {
            
        },
        data: function() {
            return {
                intersectionOptions: {
                    threshold: [0.75]
                }
            };
        },

        methods: {
            onWaypoint({ el, going, direction }) {
                if( this.$waypointMap.GOING_IN === going ) {
                    el.classList.add('active')
                }
            }
        },

        mounted() {

        },
    });
};

// Execute async function
main().then((value) => {
    
});