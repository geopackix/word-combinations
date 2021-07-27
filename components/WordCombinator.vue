<!-- Please remove this file from your project -->
<template>
  <div>
    <div class="vertical-center">
      <div class="wordcom">
        <table>
          <tr>
            <td>
              <h1 v-on:click="newWord">{{ word }}</h1>
            </td>
          </tr>
          <tr>
            <td class="d-flex justify-content-center">
              <p
                class="h2 mb-0 word-heart"
                v-on:click="like"
                @mouseover="hover = true"
                @mouseleave="hover = false"
              >
                <b-icon icon="heart-fill" v-if="hover"></b-icon>
                <b-icon icon="heart" v-if="!hover"></b-icon>
              </p>
            </td>
          </tr>
        </table>
      </div>
    </div>
    <div class="tags">
      <b-form-group
        id="fieldset-1"
        :description="'Anzahl möglicher Wortkombinationen: ' + posCount"
        label="Wortliste"
        label-for="tags-basic"
      >
        <b-input-group class="mb-3"
          ><b-form-tags
            input-id="tags-basic"
            v-model="wordlist"
            size="lg"
            tag-pills
            tag-variant="light"
            placeholder="Neues Wort"
          ></b-form-tags
          ><b-input-group-append>
            <b-button @click="deleteTags()" variant="dark"
              ><b-icon icon="trash2"></b-icon
            ></b-button> </b-input-group-append></b-input-group
      ></b-form-group>
    </div>
    <div class="like-list" v-if="likes">
      <p v-for="w in likelist" :key="w">
        {{ w }}
      </p>
    </div>
  </div>
</template>

<script lang="ts">
module.exports = {
  data: function () {
    return {
      wordlist: ['Sprache', 'Text', 'Klar'],
      word: 'TESTWORT',
      likelist: [],
      hover: false,
    }
  },
  mounted() {
    let vm = this
    if (localStorage.wordlist) {
      this.wordlist = localStorage.wordlist.split(',')
    }
    if (localStorage.likelist) {
      this.likelist = localStorage.likelist.split(',')
    }
    window.addEventListener('keyup', (event) => {
      if (event.code === 'Space') {
        vm.newWord()
      }
    })
    this.newWord()
  },
  created: function () {},
  watch: {
    wordlist: {
      handler: function (val: any) {
        localStorage.wordlist = val
      },
    },
    likelist: {
      handler: function (val: any) {
        localStorage.likelist = val
      },
    },
  },
  methods: {
    newWord: function () {
      let vm: any = this

      if (vm.wordlist.length > 0) {
        console.log('calculate new word combination')

        let numberOfWords = vm.wordlist.length

        let firstRandom: number = Math.round(Math.random() * numberOfWords)
        if (firstRandom >= numberOfWords) {
          firstRandom -= 1
        } else if (firstRandom < 0) {
          firstRandom = 0
        }

        let secondRandom: number = Math.round(Math.random() * numberOfWords)
        if (secondRandom >= numberOfWords) {
          secondRandom -= 1
        } else if (secondRandom < 0) {
          secondRandom = 0
        }

        if (secondRandom == firstRandom) {
          vm.word = vm.wordlist[firstRandom] + ''
        } else {
          vm.word = vm.wordlist[firstRandom] + '' + vm.wordlist[secondRandom]
        }
      }
    },
    like: function () {
      let vm: any = this

      if (vm.likelist.indexOf(vm.word.toUpperCase()) < 0) {
        vm.likelist.push(vm.word.toUpperCase())
      }
      if (vm.likelist.length > 5) {
        vm.likelist.shift()
      }
    },
    deleteTags: function () {
      let vm: any = this

      vm.wordlist = []
    },
  },
  computed: {
    // a computed getter
    posCount: function (): any {
      let vm: any = this
      return vm.wordlist.length * vm.wordlist.length
    },
    likes: function (): any {
      let vm: any = this
      if (vm.likelist.length > 0) {
        return true
      } else {
        return false
      }
    },
  },
}
</script>

<style scoped>
@import '~assets/fonts/fonts.scss';

.vertical-center {
  min-height: 100%; /* Fallback for browsers do NOT support vh unit */
  min-height: 100vh; /* These two lines are counted as one :-)       */

  display: flex;
  align-items: center;
}
.wordcom {
  margin: auto;
  padding: 10px;
  cursor: pointer;
  -webkit-user-select: none; /* Chrome all / Safari all */
  -moz-user-select: none; /* Firefox all */
  -ms-user-select: none; /* IE 10+ */
  user-select: none; /* Likely future */
}

.wordcom h1 {
  text-shadow: 1px 2px #b9b9b9, -1px -2px #fff;
  font-family: 'Major-Mono-Display', monospace;
}

.wordcom .word-heart {
  margin-top: 1em;
}

.tags {
  position: absolute;
  top: 10px;
  left: 25%;
  width: 50%;
}

.like-list {
  background: #a3a3a349;
  border-radius: 10px;
  padding: 3px;
  padding-left: 2em;
  padding-right: 2em;
  font-family: 'Overpass-Mono', monospace;
  font-size: 1em;
}

@media (max-aspect-ratio: 2/2) {
  .like-list {
    position: absolute;
    bottom: 2em;
    right: 2em;
  }
  .wordcom h1 {
    font-size: 3em;
  }
}

@media (min-aspect-ratio: 2/2) {
  .like-list {
    position: absolute;
    top: 2em;
    right: 2em;
  }
  .wordcom h1 {
    font-size: 5em;
  }
}

.like-list p {
  margin: 0;
}
</style>
