
import Vue from 'vue';
import Vuetify from 'vuetify';
import colors from 'vuetify/lib/util/colors'

Vue.use(Vuetify)

export default new Vuetify({
    theme: {
    themes: {
      light: {
        primary: colors.green.lighten3, // #E53935
        secondary: colors.cyan.darken3, // #FFCDD2
        accent: colors.blue.accent4, // #3F51B5
      },
    },
  },
})

