
<template>
  <div class="max-w-md m-auto py-10">
    <div class="text-red" v-if="error">{{ error }}</div>
    <h3 class="font-mono font-regular text-3xl mb-4">Новый проект</h3>
    <form class="mb-6 p-4 pr-8 bg-white rounded border border-grey-light mt-4" action="" @submit.prevent="addProject">
      <input class="shadow appearance-none  mb-2 rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none "
        autofocus autocomplete="off"
        placeholder="Название проекта"
        v-model="newProject.name" />
      
      <input class="shadow appearance-none  mb-2 pb-8 rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none "
        autofocus autocomplete="off"
        type="text"
        placeholder="Краткое описание"
        v-model="newProject.description" />
      <input type="submit" value="Создать" class="font-sans font-bold px-4 rounded cursor-pointer no-underline bg-gray-500 hover:bg-gray-700 block w-full py-4 text-white items-center justify-center" />
    </form>

    <hr class="border border-grey-light my-6" />

    <ul class="list-reset mt-4">
      <li class="py-4" v-for="project in projects" :key="project.id" :project="project">

        <div class="flex items-center justify-between flex-wrap">
          <p class="block flex-1 font-mono font-semibold flex items-center ">
          <router-link :to="{ name: 'Project', params: { id: project.id }}">{{ project.name }}</router-link>
          </p>

          <button class="bg-tranparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 mr-2 rounded"
          @click.prevent="editProject(project)">Редактировать</button>

          <button class="bg-transprent text-sm hover:bg-red text-red hover:text-white no-underline font-bold py-2 px-4 rounded border border-red"
         @click.prevent="removeProject(project)">Удалить</button>
        </div>

        <div v-if="project == editedProject">
          <form action="" @submit.prevent="updateProject(project)">
            <div class="mb-6 p-4 bg-white rounded border border-grey-light mt-4">
             <input class="shadow appearance-none  mb-2 rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none "
              autofocus autocomplete="off"
              placeholder="Название проекта"
              v-model="project.name" />
             <input class="shadow appearance-none  mb-2 pb-8 rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none "
                autofocus autocomplete="off"
                type="text"
                placeholder="Краткое описание"
                v-model="project.description" />
              <input type="submit" value="Сохранить" class=" my-2 bg-transparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 rounded cursor-pointer">
            </div>
          </form>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'Projects',
  data () {
    return {
      projects: [],
      newProject: [],
      error: '',
      editedProject: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/projects')
        .then(response => { this.projects = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    addProject () {
      const value = this.newProject
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/projects/', { project: { name: this.newProject.name } })

        .then(response => {
          this.projects.push(response.data)
          this.newProject = ''
        })
        .catch(error => this.setError(error, 'Cannot create project'))
    },
    removeProject (project) {
      this.$http.secured.delete(`/api/v1/projects/${project.id}`)
        .then(response => {
          this.projects.splice(this.projects.indexOf(project), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete project'))
    },
    editProject (project) {
      this.editedProject = project
    },
    updateProject (project) {
      this.editedProject = ''
      this.$http.secured.patch(`/api/v1/projects/${project.id}`, { project: { title: project.name } })
        .catch(error => this.setError(error, 'Cannot update project'))
    }
  }
}
</script>
