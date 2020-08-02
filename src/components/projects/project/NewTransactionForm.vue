<template>
<form action="" @submit.prevent="createTransaction(newTransaction)">
  <div class="flex flex-wrap  mb-6">
    <div class="w-full md:w-1/6  mb-6 md:mb-0 pr-3">
      <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-first-name">
        Сумма
      </label>
      
      <currency-input v-model="this.newTransaction.amount" class="appearance-none block w-full bg-gray-200 text-gray-700 rounded py-3 px-4 mb-3 leading-tight  focus:bg-white" />
    </div>
    <div class="w-full md:w-1/6 px-3">
      <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-last-name">
        Назначение
      </label>
      <date-picker v-model="this.newTransaction.started_date" inputClass="w-full appearance-none block w-full bg-gray-200 text-gray-700 rounded py-3 px-4 mb-3 leading-tight  focus:bg-white" valueType="format"></date-picker>

    </div>
    
    <div class="w-full md:w-1/6 px-3">
      <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-last-name">
        Родительский сегмент
      </label>
      <select v-model="this.newTransaction.parent_id" class="block appearance-none w-full bg-gray-200 border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500">
        <option  v-for="segment in segments" :key="segment.id" :segment="segment" :value="segment.id">{{ segment.name }}</option>
      </select>
    </div>

    <input type="submit" value="Добавить" class=" mb-3 mt-6 bg-transparent text-sm hover:bg-blue hover:text-white hover:bg-gray-700 text-blue border border-blue no-underline font-bold px-4 rounded cursor-pointer">
  </div>
</form>
</template>
<script>
import 'vue2-datepicker/index.css'

export default {
  name: 'NewTransactionForm',
  data () {
    return {
      newTransaction: {},
      error: ''
    }
  },
  components: {
    
  },
 
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    }
  }
}
</script>
