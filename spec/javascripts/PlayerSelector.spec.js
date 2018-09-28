import { shallow } from 'vue-test-utils'
import Vue from 'vue'
import PlayerSelector from 'components/PlayerSelector'

describe('PlayerSelector.vue', () => {
  let wrapper

  beforeEach(() => {
    wrapper = shallow(PlayerSelector, {
      propsData: {
        player: 1,
        playerType: 'human'
      }
    })
  })

  it('emits a "setPlayerType" event when "computer" is picked', () => {
    const stub = jest.fn()
    wrapper.vm.$on('setPlayerType', stub)
    wrapper.find('#player1computer').trigger('click')
    expect(stub).toBeCalledWith(1, 'computer')
  })

  it('emits a "setPlayerType" event when "human" is picked', () => {
    const stub = jest.fn()
    wrapper.vm.$on('setPlayerType', stub)
    wrapper.find('#player1computer').trigger('click')
    wrapper.find('#player1human').trigger('click')
    expect(stub).toBeCalledWith(1, 'human')
  })

  it('has the expected html structure', () => {
    expect(wrapper.element).toMatchSnapshot()
  })
})
