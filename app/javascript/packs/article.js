import $ from 'jquery'
import axios from 'axios'


axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()


const handleCommentForm = () => {
    $('.show-comment-form').on('click', () => {
        $('.show-comment-form').addClass('hidden')
        $('.comment-text-area').removeClass('hidden')
    })

}

const appendNewComment = (comment) => {
    $('.comments-container').append(
        `<div class="article_comment"><P>${escape(comment.content)}</P></div>`
    )
}

document.addEventListener('DOMContentLoaded', () => {
    const dataset = $('#<%= timeline.id %>').data()
    const timelinesId = dataset.timelinesId

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
    
    listenInactiveHeartEvent(timelinesId)
    listenActiveHeartEvent(timelinesId)
    
})