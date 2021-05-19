// App main
const main = async() => {
    // Async load the vue module
    const { default: Vue } = await import(/* webpackChunkName: "vue" */ 'vue');
    
    // Create our vue instance
    const vm = new Vue({
        el: "#mobile-menu",
        components: {
            'mobile-menu': () => import(/* webpackChunkName: "mobilemenu" */ '@/vue/MobileMenu.vue'),
        },
        data: function() {
            return {
            
            };
        },
        mounted() {

        },
        methods: {

        },
    });
};

// Execute async function
main().then((value) => {
    
});