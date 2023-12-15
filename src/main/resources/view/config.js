// import { GraphicEntityModule } from './entity-module/GraphicEntityModule.js'
import { ViewModule,  api} from './graphics/ViewModule.js';
import { EndScreenModule } from './endscreen-module/EndScreenModule.js';

// List of viewer modules that you want to use in your game
export const modules = [
  ViewModule,
  EndScreenModule
]

export const playerColors = [
  '#f6832c', // Cadmium orange
  '#b130c0', // Barney purple
]

export const options = [
  { 
    title: 'DEBUG MODE',
    get: function () {
      return api.options.debugMode
    },
    set: function (value) {
      api.options.debugMode = value
    },
    values: {
      'ON': true,
      'OFF': false
    }, 
  }, {
    title: 'SHOW FISH HABITAT',
    get: function () {
      return api.options.showFishHabitat
    },
    set: function (value) {
      api.options.showFishHabitat = value
    },
    values: {
      'ON': true,
      'OFF': false
    }
  }, {
    title: 'MY MESSAGES',
    get: function () {
      return api.options.showMyMessages
    },
    set: function (value) {
      api.options.showMyMessages = value
    },
    enabled: function () {
      return api.options.meInGame
    },
    values: {
      'ON': true,
      'OFF': false
    }
  }, {
    title: 'OTHERS\' MESSAGES',
    get: function () {
      return api.options.showOthersMessages
    },
    set: function (value) {
      api.options.showOthersMessages = value
    },
  
    values: {
      'ON': true,
      'OFF': false
    }
  }, {
    title: 'ENABLE DARKNESS',
    get: function () {
      return api.options.darkness
    },
    set: function (value) {
      api.options.darkness = value
    },
    enabled: function () {
      return api.options.enableDarkness
    },
    values: {
      'ON': true,
      'ORANGE': 0,
      'PURPLE': 1,
      'OFF': false
    }
  }

]


export const gameName = 'FC2023'

export const stepByStepAnimateSpeed = 3
