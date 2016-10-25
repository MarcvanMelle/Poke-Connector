import React from 'react'
import { Route } from 'react-router'
import Home from './Home'
import IndexPokeball from './Pokeballs/IndexPokeball'
import NewPokeball from './Pokeballs/NewPokeball'
import ShowPokeball from './Pokeballs/ShowPokeball'
import EditPokeball from './Pokeballs/EditPokeball'
import NewRequest from './Requests/NewRequest'
import ShowRequest from './Requests/ShowRequest'
import EditRequest from './Requests/EditRequest'

module.exports = (
  <Route path="/" component={Home}>
    <Route path="/pokeballs" component={IndexPokeball}/>
    <Route path="/pokeballs/new" component={NewPokeball}/>
    <Route path="/pokeballs/:pokeballId" component={ShowPokeball}/>
    <Route path="/pokeballs/:pokeballId/edit" component={EditPokeball}/>
    <Route path="/requests/new" component={NewRequest}/>
    <Route path="/requests/:requestId" component={ShowRequest}/>
    <Route path="/requests/:requestId/edit" component={EditRequest}/>
  </Route>
)
