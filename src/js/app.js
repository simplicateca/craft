// import CSS
import styles from '../css/app.scss';

// import fonts
// import fontname  from '../fonts/fontname.woff';
// import fontname2 from '../fonts/fontname.woff2';

// app main
const main = async () => {

    // Async load the vue module
    const { default: Vue } = await import(/* webpackChunkName: "vue" */ 'vue');

    // load the vue waypoint
    const { default: VueWaypoint } = await import(/* webpackChunkName: "vuewaypoint" */ 'vue-waypoint');
    Vue.use(VueWaypoint)

    // Create our vue instance
    const vm = new Vue({
        el: "#page-container",

        components: {
            'confetti': () => import(/* webpackChunkName: "confetti" */ '../vue/Confetti.vue'),
            'emergencymessage': () => import(/* webpackChunkName: "emergencymessage" */ '../vue/EmergencyMessage.vue'),
            'mobilemenu': () => import(/* webpackChunkName: "mobilemenu" */ '../vue/MobileMenu.vue')
        },

        data: {
            intersectionOptions: {
                threshold: [0.75]
            }
        },

        methods: {
            handleScroll (event) {
                if( window.pageYOffset >= 10 ) {
                    document.body.classList.add("scrolled");
                }

                if( window.pageYOffset == 0 ) {
                    document.body.classList.remove("scrolled");
                }
            },

            onWaypoint({ el, going, direction }) {
                if( this.$waypointMap.GOING_IN === going ) {
                    el.classList.add('active')
                }
            }
        },

        mounted() {

        },

        created () {
            document.body.classList.add("js-loaded");
            window.addEventListener('scroll', this.handleScroll);
        },
       
        destroyed () {
            window.removeEventListener('scroll', this.handleScroll);
        },
    });

    return vm;
};

// Execute async function
main().then( (vm) => {

});

// Accept HMR as per: https://webpack.js.org/api/hot-module-replacement#accept
if (module.hot) {
    module.hot.accept();
}
