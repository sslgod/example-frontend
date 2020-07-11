<template>
<div class=" py-10">
  <main class="flex flex-col flex-grow overflow-hidden">
    <div class="container mx-auto">
      <div class="flex items-center my-4">
            <div class="flex sm:w-2/3">
                <div class="flex flex-col leading-tight">
                    <h1 class="text-3xl text-secondary font-bold mb-1">
                      {{ project.name }}
                    </h1>
                    <span class="text-gray-600">
                      By <a rel="nofollow">{{ project.user.email }}</a>
                    </span>
                    <p class="text-gray-700 mt-3 leading-snug links-colored">{{ project.description }}</p>
                </div>
            </div>
          </div>
        </div>
    <div class="container mx-auto ">
      <div class="flex items-center  my-4">
        <div class="flex">
          <div class="flex flex-col leading-tight">
            <h2 class="w-auto text-2xl text-secondary font-bold mb-1">
              Финансы
              <button @click.prevent="addTransaction()">
                <ButtonCircleAdd/>
              </button>
            </h2>
          </div>
        </div>
      </div>
    </div>
    <div class="container mx-auto ">
      <div class="flex items-center   my-4">
        <div class="flex w-full  flex-col">
          <h2 class="text-2xl text-secondary font-bold mb-1">
            Этапы
            <button @click.prevent="addSegment()">
              <ButtonCircleAdd/>
            </button>
          </h2>
          <div v-if="newSegment != ''" class="pt-2">
            <form action="" @submit.prevent="createSegment(newSegment)">
              <div class="flex flex-wrap  mb-6">
                <div class="w-full md:w-1/6  mb-6 md:mb-0">
                  <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-first-name">
                    Название
                  </label>
                  
                  <input v-model="newSegment.name" class="appearance-none block w-full bg-gray-200 text-gray-700 rounded py-3 px-4 mb-3 leading-tight  focus:bg-white" id="grid-first-name" type="text" placeholder="Дизайн">
                </div>
                <div class="w-full md:w-2/6 px-3">
                  <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-last-name">
                    Продолжительность
                  </label>
                  <date-picker v-model="newSegment.started_date" range inputClass="w-full appearance-none block w-full bg-gray-200 text-gray-700 rounded py-3 px-4 mb-3 leading-tight  focus:bg-white" valueType="format"></date-picker>
                </div>
                <input type="submit" value="Сохранить" class=" mb-3 mt-6 bg-transparent text-sm hover:bg-blue hover:text-white hover:bg-gray-700 text-blue border border-blue no-underline font-bold px-4 rounded cursor-pointer">
              </div>
            </form>
          </div>
          <Chart :project="project" />
          <ul class="list-reset mt-4">
            <li  v-for="segment in project.segments" :key="segment.id" :segment="segment">
              <div class="flex items-center justify-between flex-wrap">
                <p class="block flex-1 font-mono font-semibold flex items-center ">
                <a>- {{ segment.name }}</a>
                </p>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </main>
</div>
</template>
<script>
  import ButtonCircleAdd from '../shared/ButtonCircleAdd.vue'
  import Chart from './project/Chart.vue'
  import DatePicker from 'vue2-datepicker';
  import 'vue2-datepicker/index.css';

export default {
  name: 'Project',
  data () {
    return {
      time1: null,
      project: {},
      newSegment: {},
      error: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/projects/'+ this.$route.params.id )
        .then(response => { this.project = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  components: {
    ButtonCircleAdd,
    DatePicker,
    Chart
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    addSegment(){
      this.newSegment = {}
    },
    createSegment(){
      const value = this.newSegment
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/projects/' + this.project.id +'/segments/', { segment: { name: this.newSegment.name } })
        .then(response => {
          this.project.segments.push(response.data)
          this.newSegment = ''
        })
        .catch(error => this.setError(error, 'Cannot create project'))
    }
  }
}
</script>
<style>
.mx-datepicker-range {
  width: 100%;
}
</style>
