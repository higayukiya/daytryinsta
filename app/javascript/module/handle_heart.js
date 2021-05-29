import $ from 'jquery'
import axios from 'axios'
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()


const listenInactiveHeartEvent = (timelineId) => {
    $('.inactive-heart').on('click', () => {
        axios.post(`/api/timelines/${timelineId}/like`)
            .then((response) => {
                if (response.data.status === 'ok') {
                    $('.active-heart').removeClass('hidden')
                    $('.inactive-heart').addClass('hidden')
                }
            })
    
            .catch((e) => {
                window.alert('error')
                console.log(e)
        })
    })
}

const listenActiveHeartEvent = (timelineId) => {
    $('.active-heart').on('click', () => {
        axios.delete(`/api/timelines/${timelineId}/like`)
            .then((response) => {
                if (response.data.status === 'ok') {
                    $('.active-heart').addClass('hidden')
                    $('.inactive-heart').removeClass('hidden')
                }
    
            })
            .catch((e) => {
                window.alert('error')
                console.log(e)
            })
    })
}

export {
    listenInactiveHeartEvent,
    listenActiveHeartEvent
}