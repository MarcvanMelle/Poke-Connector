import React from 'react'
import { Route } from 'react-router'
import Home from './Home'
import HomePage from './HomePage'
import IndexPokeball from './Pokeballs/IndexPokeball'
import NewPokeball from './Pokeballs/NewPokeball'
import ShowPokeball from './Pokeballs/ShowPokeball'
import EditPokeball from './Pokeballs/EditPokeball'
import IndexRequest from './Requests/IndexRequest'
import NewRequest from './Requests/NewRequest'
import ShowRequest from './Requests/ShowRequest'
import EditRequest from './Requests/EditRequest'
import UserSignUp from './Users/UserSignUp'
import UserSignIn from './Users/UserSignIn'
import UserShow from './Users/UserShow'

module.exports = (
  <Route path="" component={Home}>
    <Route path="/" component={HomePage}/>
    <Route path="/pokeballs" component={IndexPokeball}/>
    <Route path="/pokeballs/new" component={NewPokeball}/>
    <Route path="/pokeballs/:pokeballId" component={ShowPokeball}/>
    <Route path="/pokeballs/:pokeballId/edit" component={EditPokeball}/>
    <Route path="/requests" component={IndexRequest}/>
    <Route path="/requests/new" component={NewRequest}/>
    <Route path="/requests/:requestId" component={ShowRequest}/>
    <Route path="/requests/:requestId/edit" component={EditRequest}/>
    <Route path="/users/sign_up" component={UserSignUp}/>
    <Route path="/users/sign_in" component={UserSignIn}/>
    <Route path="/users/password/new"/>
    <Route path="/users/edit"/>
    <Route path="/users/:userId" component={UserShow}/>
  </Route>
)
