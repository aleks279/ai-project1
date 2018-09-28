import { shallow } from 'vue-test-utils'
import Vue from 'vue'
import ResetButton from 'components/ResetButton'

describe('ResetButton.vue', () => {
  let wrapper

  beforeEach(() => {
    wrapper = shallow(ResetButton)
  })

  it('emits a "resetGame" event when clicked', () => {
    const stub = jest.fn()
    wrapper.vm.$on('resetGame', stub)
    wrapper.find('button').trigger('click')
    expect(stub).toBeCalled()
  })

  it('has the expected html structure', () => {
    expect(wrapper.element).toMatchSnapshot()
  })
})
