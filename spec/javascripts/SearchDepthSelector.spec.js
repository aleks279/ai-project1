import { shallow } from 'vue-test-utils'
import Vue from 'vue'
import SearchDepthSelector from 'components/SearchDepthSelector'

describe('SearchDepthSelector.vue', () => {
  let wrapper

  beforeEach(() => {
    wrapper = shallow(SearchDepthSelector, {
      propsData: {
        searchDepth: 3
      }
    })
  })

  it('emits a "setSearchDepth" event when an option is picked', () => {
    const stub = jest.fn()
    wrapper.vm.$on('setSearchDepth', stub)
    for (let i = 0; i < 5; i++) {
      wrapper.findAll('option').at(i).trigger('change')
      expect(stub).toBeCalledWith(i+1)
    }
  })

  it('has the expected html structure', () => {
    expect(wrapper.element).toMatchSnapshot()
  })
})
