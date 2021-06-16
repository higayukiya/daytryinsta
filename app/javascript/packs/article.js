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
        `<div class="timelines_comment"><P>${escape(comment.content)}</P></div>`
    )
}

document.addEventListener('DOMContentLoaded', () => {
    const dataset = $('#<%= timeline.id %>').data()
    const timelinesId = dataset.timelinesId

    axios.get(`/timelines/${timelinesId}/comments`)
        .then((response) => {
            const comments = response.data
            comments.forEach((comment) => {
                appendNewComment(comment)
            })
        })
    
        handleCommentForm()

    $('.comment_submit').on('click', () => {
        const content = $('#comment_content').val()
        debugger
        if (!content) {
            window.alert('コメントを入力してください')
        } else {
            axios.post(`/articles/${timelinesId}/comments`, {
                comment: { content: content }
            })
                .then((res) => {
                    const comment = res.data
                    appendNewComment(comment)
                    $('#comment_content').val('')
                })
        }
    })
    
    listenInactiveHeartEvent(timelinesId)
    listenActiveHeartEvent(timelinesId)
    
})