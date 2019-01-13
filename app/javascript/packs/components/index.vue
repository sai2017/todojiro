<template>
  <div>
    <div class="row">
      <div class="col s10 m11">
        <input v-model="newJiro" class="form-control" placeholder="お好みを追加してください">
      </div>
      <div class="col s2 m1">
        <div v-on:click="createJiro" class="btn-floating waves-effect waves-light red">
          <i class="material-icons">add</i>
        </div>
      </div>
    </div>
    <div>
      <ul class="collection">
        <li v-for="jiro in jiros" v-if="jiro.is_done" v-bind:id="'row_jiro_' + jiro.id" class="collection-item">
          <label v-bind:for="'jiro' + jiro.id">
            <input type="checkbox" v-on:change="doneJiro(jiro.id)" v-bind:id="'jiro' + jiro.id" />
            <span>{{ jiro.name }}</span>
          </label>
        </li>
      </ul>
    </div>

    <div class="btn" v-on:click="displayFinishedJiros">Display finished jiros</div>

    <div id="finished-jiros" class="display_none">
      <ul class="collection">
        <li v-for="jiro in jiros" v-if="jiro.is_done" v-bind:id="'row_jiro_' + jiro.id" class="collection-item">
          <label v-bind:for="'jiro' + jiro.id">
            <input type="checkbox" v-bind:id="'jiro' + jiro.id" />
            <span>{{ jiro.name }}</span>
          </label>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data: function() {
      return {
        jiros: [],
        newJiro: ''
      }
    },
    mounted: function() {
      this.fetchJiros();
    },
    methods: {
      fetchJiros: function() {
        axios.get('/api/jiros').then((response) => {
          for(var i = 0; i < response.data.jiros.length; i++) {
            this.jiros.push(response.data.jiros[i]);
          }
        }, (error) => {
          console.log(error);
        });
      },
      displayFinishedJiros: function() {
        document.querySelector('#finished-jiros').classList.toggle('display_none');
      },
      createJiro: function() {
        if (!this.newJiro) return;

        axios.post('/api/jiros', { jiro: { name: this.newJiro } }).then((response) => {
          this.jiros.unshift(response.data.jiro);
          this.newJiro = '';
        }, (error) => {
          console.log(error);
        });
      },
      moveFinishedJiro: function(jiro_id) {
        var el = document.querySelector('#row_jiro_' + jiro_id);
        var el_clone = el.cloneNode(true);
        el.classList.add('display_none');
        el_clone.getElementsByTagName('input')[0].checked = 'checked';
        el_clone.getElementsByTagName('input')[0].classList.add('line_through');
        el_clone.getElementsByTagName('input')[0].classList.remove('word-color-black');
        var i = document.querySelector('#finished-jiros > ul > li:first-child');
        document.querySelector('#finished-jiros > ul').insertBefore(el_clone, li);
      }
    }
  }
</script>

<style scoped>
  [v-cloak] {
    display: none;
  }
  .display_none {
    display: none;
  }
  .line_through {
    text-decoration: line-through;
  }
</style>