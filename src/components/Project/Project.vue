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
      <div class="flex items-center   my-4">
        <div class="flex w-full  flex-col">
          <h2 class="text-2xl text-secondary font-bold mb-1">
              Финансы
          </h2>
          <div  class="pt-2">
            <ProjectTransactionForm :project="project" />
          </div>
          <ul>
            <li  v-for="transaction in project.transactions" :key="transaction.id" :transaction="transaction">
              <div class="flex flex-wrap  mb-6">

                <div class="w-full md:w-1/6  mb-6 md:mb-0 pr-3">
                  <b class='md:w-1/6 py-2 px-3'>{{typeIcons[transaction.transaction_type]}}</b>
                  {{ transaction.amount }}
                </div>

                <div class="w-full md:w-1/6 px-3">
                  {{ project.segments.find((el, id, ar)=>{return el.id==transaction.segment_id}).name }}
                </div>

                <div class="w-full md:w-1/6 px-3">
                  {{ Date(transaction.date) | moment("MMM DD") }}
                </div>

                <div class="w-full md:w-2/6 px-3">
                  {{ transaction.comment }}
                </div>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </div>
    <div class="container mx-auto ">
      <div class="flex items-center   my-4">
        <div class="flex w-full  flex-col">
          <h2 class="text-2xl text-secondary font-bold mb-1">
            Этапы
          </h2>
          <div  class="pt-2">
            <ProjectSegmentForm :project="project" />
          </div>
          <ProjectChart :project="project" />
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
import ProjectChart from './components/ProjectChart.vue'
import ProjectSegmentForm from './components/ProjectSegmentForm.vue'
import ProjectTransactionForm from './components/ProjectTransactionForm.vue'

export default {
  name: 'Project',
  data () {
    return {
      project: {},
      typeIcons: {
        in: '+',
        out: '-'
      },
      error: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/projects/' + this.$route.params.id)
        .then(response => {
          this.project = response.data
        })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  components: {
    ProjectSegmentForm,
    ProjectTransactionForm,
    ProjectChart
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    }
  }
}
</script>
<style>
.mx-datepicker-range {
  width: 100%;
}
.mx-datepicker {
    width: auto;
}
</style>
