Vue.component 'auth',
  template:"""
    <div v-if="loggedIn()">
      <img :src="profile.picture" class="rounded-circle" />
      <span class="v-middle pl-1 pr-1">{{ profile.name }}</span>
      <button class="btn btn-outline-danger" v-on:click="logout()">Déconnexion</button>
    </div>
    <div v-else>
      <button class="btn btn-primary" v-on:click="login()">Connexion</button>
    </div>
  """

  data: -> {
    profile: JSON.parse(localStorage.getItem('profile'))
    token: localStorage.getItem('id_token')
  }

  methods:
    login: ->
      self = this
      lock.show (err, profile, id_token) ->
        localStorage.setItem('profile', JSON.stringify(profile))
        localStorage.setItem('id_token', id_token)
        self.profile = profile
        self.token = id_token
        return
      return

    logout: ->
      localStorage.removeItem('profile')
      localStorage.removeItem('id_token')
      this.profile = undefined
      this.token = undefined
      return

    loggedIn: ->
      this.profile && this.token

auth = new Vue(
  el: '#user'
)
