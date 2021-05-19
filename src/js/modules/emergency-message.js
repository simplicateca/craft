// App main
const main = async() => {
    // Async load the vue module
    const { default: Vue } = await import(/* webpackChunkName: "vue" */ 'vue');
    
    // Create our vue instance
    const vm = new Vue({
        el: "#emergency-message",
        components: {
            'emergency-message': () => import(/* webpackChunkName: "emergencymessage" */ '@/vue/EmergencyMessage.vue'),
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