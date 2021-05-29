import $ from 'jquery'
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
import {
    listenInactiveHeartEvent,
    listenActiveHeartEvent
} from 'modules/handle_heart'

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

const handleHeartDisplay = (hasLiked) => {
    if (hasLiked) {
        $('.active-heart').removeClass('hidden')
    } else {
        $('.inactive-heart').removeClass('hidden')
    }
}

const handleCommentForm = () => {
    $('.show-comment-form').on('click', () => {
        $('.show-comment-form').addClass('hidden')
        $('.comment-text-area').removeClass('hidden')
    })

}

const appendNewComment = (comment) => {
    $('.comments-container').append(
        `<div class="article_comment"><P>${escape(comment.contens)}</P></div>`
    )
}

document.addEventListener('DOMContentLoaded', () => {
    const dataset = $('#article-show').data()
    const articleId = dataset.articleId

    axios.get(`/api/articles/${articleId}/comments`)
        .then((response) => {
            const comments = response.data
            comments.forEach((comment) => {
                appendNewComment(comment)
            })
        })
    
        handleCommentForm()

    $('.add-comment-button').on('click', () => {
        const contens = $('#comment_contens').val()
        if (!contens) {
            window.alert('コメントを入力してください')
        } else {
            axios.post(`/api/articles/${articleId}/comments`, {
                comment: { contens: contens }
            })
                .then((res) => {
                    const comment = res.data
                    appendNewComment(comment)
                    $('#comment_contens').val('')
                })
        }
    })

    axios.get(`/api/articles/${articleId}/like`)
        .then((response) => {
            const hasLiked = response.data.hasLiked
            handleHeartDisplay(hasLiked)
        })
    
    listenInactiveHeartEvent(articleId)
    listenActiveHeartEvent(articleId)
    
})