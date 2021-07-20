// import CSS
import styles from '../css/app.pcss';

// app main
const main = async () => {

    // Async load the vue module
    const { default: Vue } = await import(/* webpackChunkName: "vue" */ 'vue');

    // Create our vue instance
    const vm = new Vue({
        el: '#component-container',

        components: {
            'confetti': () => import(/* webpackChunkName: "confetti" */ '../vue/Confetti.vue'),
        },

        data: function() {
            return {

            };
        },

        methods: {
            handleScroll (event) {
                if( window.pageYOffset >= 120 ) {
                    document.body.classList.add("scrolled");
                }

                if( window.pageYOffset == 0 ) {
                    document.body.classList.remove("scrolled");
                }
            },

            handleUnload( event ) {
                document.querySelector('div.loader').classList.add('unload');
            }
        },

        mounted() {

        },

        created () {
            document.body.classList.add("js-loaded");
            document.querySelector('div.loader').classList.add('active');
            window.addEventListener('scroll', this.handleScroll);
            window.addEventListener('beforeunload', this.handleUnload);
        },
       
        destroyed () {
            window.removeEventListener('scroll', this.handleScroll);
            window.removeEventListener('beforeunload', this.handleUnload);
        },
    })

    return vm;
};

// Execute async function
main().then( (vm) => {
});

// Accept HMR as per: https://webpack.js.org/api/hot-module-replacement#accept
if (module.hot) {
    module.hot.accept();
}
