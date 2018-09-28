jest.mock('axios', () => ({
  get: jest.fn(() => Promise.resolve({
    data: {
      "moves": [1,2], 
      "computer_move": 6
    }
  }))
}))
import { shallow } from 'vue-test-utils'
import Vue from 'vue'
import App from 'components/App'
import axios from 'axios'

describe('App.vue', () => {
  let wrapper

  beforeEach(() => {
    jest.resetModules()
    jest.clearAllMocks()
    wrapper = shallow(App)
  })

  it('gets a computer move when player 1 is a computer', () => {
    wrapper.setData({
      moves: [1,2],
      playerOneType: "computer",
      playerTwoType: "human",
      playerToMove: 1,
      gameResult: 'incomplete',
      movesAllowed: true,
      searchDepth: 3
    })
    wrapper.update()
    Vue.nextTick(function () {
      expect(axios.get).toBeCalledWith('/games/computer_move.json?moves=1,2&depth=3')
      Vue.nextTick(function () {
        Vue.nextTick(function () {
          expect(wrapper.vm.moves).toEqual([1,2,6])
        })
      })
    })
  })

  it('gets the game result after a computer move', () => {
    wrapper.setData({
      moves: [1,2],
      playerOneType: "computer",
      playerTwoType: "human",
      playerToMove: 1,
      gameResult: 'incomplete',
      movesAllowed: true,
      searchDepth: 3
    })
    wrapper.update()
    Vue.nextTick(function () {
      Vue.nextTick(function () {
        Vue.nextTick(function () {
          expect(axios.get).toBeCalledWith('/games/game_result.json?moves=1,2,6')
        })
      })
    })
  })

  it('gets the game result after a human move', () => {
    wrapper.vm.$root.$emit('move', 5);
    wrapper.vm.move(5)
    expect(axios.get).toBeCalledWith('/games/game_result.json?moves=5')
  })

  it('has the expected html structure', () => {
    expect(wrapper.element).toMatchSnapshot()
  })
})
