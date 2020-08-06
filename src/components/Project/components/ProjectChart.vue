<template>
<div class="flex flex-col md:flex-row">
  <div class="main-content flex-1 mt-12 md:mt-2 pb-24 md:pb-5">
    <div class="flex flex-row flex-wrap flex-grow mt-2">
      <div class="w-full p-3">
        <div class="bg-white border-transparent rounded-lg shadow-lg">
          <div class="p-5">
            <JSCharting :options="options"></JSCharting>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</template>
<script>
import JSCharting from 'jscharting-vue'
import moment from 'moment-timezone'

export default {

  name: 'ProjectChart',
  data () {
    return {
      project: this.$attrs.project,

      options: {
        debug: false,
        type: 'horizontal column',
        zAxisScaleType: 'stacked',
        yAxis_scale_type: 'time',
        legend_position: 'bottom',
        title_label_text:
          'Project Beta from %min to %max',
        yAxis: {
          markers: this.$attrs.project.transactions.flatMap(transaction => [
            {
              value: moment(new Date(transaction.date)).format('l'),
              label_text: transaction.transaction_type + ' ' + transaction.amount
            }
          ])
        },
        defaultSeries: {
          defaultPoint: {
            legendEntry: {
              value: '{days(%max-%min):number n0} days'
            },
            tooltip:
              '<b>%name</b> <br/>%low - %high<br/>{days(%high-%low)} days',
            marker_type: 'diamond'
          },
          firstPoint: {
            visible: true,
            xAxisTick: {
              label: {
                text: '<b>%name</b>',
                style: { fontSize: '14px' }
              }
            },
            outline: { color: 'darkenMore', width: 3 }
          }
        },
        series: []
      }
    }
  },

  created () {
    function toPoints (segment, parent) {
      var points = []
      if (segment.parent_id === null) {
        console.log(moment(Date(segment.started_date)).format('l'))
        points = [{
          name: segment.name,
          y: [moment(new Date(segment.started_date)).format('l'), moment(new Date(segment.due_date)).format('l')]
        }]
      } else {
        points = [{
          name: parent.name,
          y: [moment(new Date(parent.started_date)).format('l'), moment(new Date(parent.due_date)).format('l')]
        }]
      }

      if (segment.children) {
        points.concat([ segment.children.flatMap(s => [ toPoints(s) ]) ])
      }
      return points
    }

    this.options.series = this.project.segments.flatMap(segment => [
      {
        name: segment.name,
        points: toPoints(segment)
      }
    ])
  },
  components: {
    JSCharting,
    moment
  }
}
</script>
