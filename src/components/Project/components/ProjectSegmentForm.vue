<template>
<form action="" @submit.prevent="createSegment(newSegment)">
  <div class="flex flex-wrap  mb-6">
    <div class="w-full md:w-1/6  mb-6 md:mb-0 pr-3">
      <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-first-name">
        Название
      </label>

      <input v-model="newSegment.name" class="appearance-none block w-full bg-gray-200 text-gray-700 rounded py-3 px-4 mb-3 leading-tight  focus:bg-white" id="grid-first-name" type="text" placeholder="Дизайн">
    </div>
    <div class="w-full md:w-1/6 px-3">
      <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-last-name">
        Дата начала
      </label>
      <date-picker v-model="newSegment.started_date" inputClass="w-full appearance-none block w-full bg-gray-200 text-gray-700 rounded py-3 px-4 mb-3 leading-tight  focus:bg-white" valueType="format"></date-picker>

    </div>
    <div class="w-full md:w-1/6 px-3">
      <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-last-name">
        Продолжительность
      </label>
      <input v-model="newSegment.days_duration" class="appearance-none block w-full bg-gray-200 text-gray-700 rounded py-3 px-4 mb-3 leading-tight  focus:bg-white" id="grid-first-name" type="text" placeholder="В днях">

    </div>

    <div class="w-full md:w-1/6 px-3">
      <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-last-name">
        Родительский сегмент
      </label>
      <select v-model="newSegment.parent_id" class="block appearance-none w-full bg-gray-200 border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500">
        <option  v-for="segment in project.segments" :key="segment.id" :segment="segment" :value="segment.id">{{ segment.name }}</option>
      </select>
    </div>

    <input type="submit" value="Добавить" class=" mb-3 mt-6 bg-transparent text-sm hover:bg-blue hover:text-white hover:bg-gray-700 text-blue border border-blue no-underline font-bold px-4 rounded cursor-pointer">
  </div>
</form>
</template>
<script>
import DatePicker from 'vue2-datepicker'
import 'vue2-datepicker/index.css'

export default {
  name: 'NewSegmentForm',
  data () {
    return {
      project: this.$attrs.project,
      newSegment: {},
      error: ''
    }
  },
  components: {
    DatePicker
  },

  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },

    createSegment () {
      const value = this.newSegment
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/projects/' + this.project.id + '/segments/', { segment: value })

        .then(response => {
          this.project.segments.push(response.data)
          this.newSegment = ''
        })
        .catch(error => this.setError(error, 'Cannot create project'))
    }
  }
}
</script>
