<template>
<form action="" @submit.prevent="createTransaction(newTransaction)">
  <div class="flex flex-wrap  mb-6">

    <div class="w-full md:w-1/6  mb-6 md:mb-0 pr-3">

      <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-first-name">
        Сумма
      </label>
      <div class="flex flex-wrap">
        <b  v-on:click="newTransaction.transaction_type = Object.keys(typeIcons).find(function(o){return o!=newTransaction.transaction_type })" class='transaction_type md:w-1/6 py-2 px-3'>{{typeIcons[newTransaction.transaction_type]}}</b>
        <currency-input v-model="newTransaction.amount" class="appearance-none block md:w-5/6 bg-gray-200 text-gray-700 rounded py-3 pl-4 pr-5  mb-3 leading-tight  focus:bg-white" />
        <input type='hidden' v-model="newTransaction.transaction_type" />
      </div>
    </div>
    <div class="w-full md:w-1/6 px-3">
      <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-last-name">
        Назначение
      </label>
      <select v-model="newTransaction.segment_id" class="block appearance-none w-full bg-gray-200 border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500">
        <option  v-for="segment in project.segments" :key="segment.id" :segment="segment" :value="segment.id">{{ segment.name }}</option>
      </select>
    </div>

    <div class="w-full md:w-1/6 px-3">
      <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-last-name">
        Дата
      </label>
      <date-picker v-model="newTransaction.date" inputClass="w-full appearance-none block w-full bg-gray-200 text-gray-700 rounded py-3 px-4 mb-3 leading-tight  focus:bg-white" valueType="format"></date-picker>
    </div>
    <div class="w-full md:w-1/6 px-3">
      <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-last-name">
        Комментарий
      </label>
      <input v-model="newTransaction.comment" class="appearance-none block w-full bg-gray-200 text-gray-700 rounded py-3 px-4 mb-3 leading-tight  focus:bg-white" id="grid-first-name" type="text" placeholder="Описание">

    </div>

    <input type="submit" value="Добавить" class=" mb-3 mt-6 bg-transparent text-sm hover:bg-blue hover:text-white hover:bg-gray-700 text-blue border border-blue no-underline font-bold px-4 rounded cursor-pointer">
  </div>
</form>
</template>
<script>
import DatePicker from 'vue2-datepicker'
import 'vue2-datepicker/index.css'

export default {
  name: 'NewTransactionForm',
  data () {
    return {
      props: ['segments'],
      newTransaction: {
        transaction_type: 'in'
      },
      project: this.$attrs.project,
      typeIcons: {
        in: '+',
        out: '-'
      },
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

    createTransaction () {
      const value = this.newTransaction
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/projects/' + this.project.id + '/transactions/', { transaction: value })

        .then(response => {
          this.project.transactions.push(response.data)
          this.newTransaction = {transaction_type: 'in'}
        })
        .catch(error => this.setError(error, 'Cannot create transaction'))
    }
  }
}
</script>
<style>
.transaction_type{
  cursor: pointer;
}
</style>
