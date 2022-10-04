// App main
const main = async() => {

    // // Async load the vue module
    // const { default: Vue } = await import(/* webpackChunkName: "vue" */ 'vue');
    
    // // load the vue waypoint
    // const { default: VueWaypoint } = await import(/* webpackChunkName: "vuewaypoint" */ 'vue-waypoint');
    // Vue.use(VueWaypoint)

    // // Create our vue instance
    // const vm = new Vue({
    //     el: "#page-container",
    //     components: {
    //         // 'emergency-message': () => import(/* webpackChunkName: "emergencymessage" */ '@/vue/EmergencyMessage.vue'),
    //         // 'confetti': () => import(/* webpackChunkName: "confetti" */ '../vue/Confetti.vue'),
    //     },
    //     data: function() {
    //         return {
    //             currentAccordion: false,
    //             modalLink : '',
    //             mobileOpen: false,
    //             intersectionOptions: {
    //                 threshold: [0.25]
    //             }
    //         };
    //     },

    //     methods: {
    //         onWaypoint({ el, going, direction }) {
    //             if( this.$waypointMap.GOING_IN === going ) {
    //                 el.classList.add('active')
    //             }
    //         },


    //         scrollToID(id) {
    //             const yOffset = -100;
    //             const element = document.getElementById(id);
    //             const y = element.getBoundingClientRect().top + window.pageYOffset + yOffset;

    //             window.scrollTo({top: y, behavior: 'smooth'});
    //         },

    //         handleScroll (event) {
    //             if( window.pageYOffset >= 120 ) {
    //                 document.body.classList.add("scrolled")
    //             }

    //             if( window.pageYOffset == 0 ) {
    //                 document.body.classList.remove("scrolled")
    //             }

    //             this.handleParallax()
    //         },

    //         handleUnload( event ) {
    //             document.querySelector('div.loader').classList.add('unload');
    //         },

    //         handleParallax() {
                
    //             // attach scroll-based parallax functionality to any element in view
    //             // -----------------------------------------------------------------
    //             // vertical movement requires a `data-rate` attribute
    //             // <div 
    //             //    class="parallax"
    //             //    data-direction="vertical"
    //             //    data-rate="0.2"
    //             // >
    //             // -----------------------------------------------------------------
    //             // horizontal movement requires a `data-ratex` and `data-ratey` attributes
    //             // <div 
    //             //    class="parallax"
    //             //    data-direction="horizontal"
    //             //    data-ratex="0.3"
    //             //    data-ratey="1.1"
    //             // >                

    //             const target = document.querySelectorAll('.parallax');
    //             let windowHeight = (window.innerHeight || document.documentElement.clientHeight);

    //             let index = 0, length = target.length;
    //             for (index; index < length; index++) {
    //                 if( this.isElementInViewport(target[index]) ) {

    //                     if( !target[index].getAttribute('data-offset-top') ) {
    //                         target[index].setAttribute('data-offset-top', target[index].getBoundingClientRect().top + window.scrollY )
    //                     }

    //                     let scrollY = ( (window.innerHeight || document.documentElement.clientHeight) + window.pageYOffset ) - target[index].getAttribute('data-offset-top');
    //                     if( target[index].getAttribute('data-offset-top') < (window.innerHeight || document.documentElement.clientHeight) ) {
    //                         scrollY = window.scrollY
    //                     }                       

    //                     if( ! isNaN(scrollY) ) {
    //                         let pos = scrollY * target[index].dataset.rate;
    //                             pos = target[index].getAttribute('data-rate-reverse') ? pos * -1 : pos;

    //                         if(target[index].dataset.direction === 'vertical') {
    //                             target[index].style.transform = 'translate3d(0px,'+pos+'px, 0px)';
    //                         } else {
    //                             let posX = scrollY * target[index].dataset.ratex;
    //                                 posX = target[index].getAttribute('data-rate-reverse') ? posX * -1 : posX;
    //                             let posY = scrollY * target[index].dataset.ratey;
    //                                 posY = target[index].getAttribute('data-rate-reverse') ? posY * -1 : posY;
    
    //                             if( target[index].getAttribute('data-rate-reverse') ) {
    //                                 let offsetX = ( windowHeight * target[index].dataset.ratex ) + target[index].offsetWidth;
    //                                 posX = offsetX + Math.abs( posX );
    //                                 posX = posX >= 0 ? 0 : posX;
    //                             }
    
    //                             target[index].style.transform = 'translate3d('+posX+'px, '+posY+'px, 0px)';
    //                         }
    //                     }
    //                 }
    //             }
    //         },

    //         handleMenuToggle( event ) {
    //             this.mobileOpen = (!this.mobileOpen);

    //             if( this.mobileOpen ) {
    //                 document.querySelector('body').classList.add('has-mobile-menu');
    //             } else {
    //                 document.querySelector('body').classList.remove('has-mobile-menu');
    //             }
    //         },
    //     },

    //     mounted() {
    //         let match = window.location.hash.match(/^#ai(\d+).*?/gi)
    //         if( match ) {
    //             let rowID = match[0].replace( '#ai', '' )
    //             let slug  = window.location.hash.replace( match[0] + '-', '' )
    //             this.openAccordion( rowID, slug )
    //             //this.scrollToID( 'ai'+rowID )
    //         } else {
    //             let match2 = window.location.hash.match(/^#([\w\-]+)/gi)
    //             if( match2 ) {
    //                 //this.scrollToID( match2[0].replace( '#', '' ) )
    //             }
    //         }
    //     },

    //     created () {
    //         document.body.classList.add("js-loaded");
    //         document.querySelector('div.loader').classList.add('active');
    //         window.addEventListener('scroll', this.handleScroll);
    //         window.addEventListener('beforeunload', this.handleUnload);
    //     },
       
    //     destroyed () {
    //         window.removeEventListener('scroll', this.handleScroll);
    //         window.removeEventListener('beforeunload', this.handleUnload);
    //     },        
    // });

    //return vm;
};

// Execute async function
main().then( (vm) => {
});

// Accept HMR as per: https://webpack.js.org/api/hot-module-replacement#accept
if (module.hot) {
    module.hot.accept();
}

