<template>
<div class="flex flex-col md:flex-row">
  <div class="main-content flex-1 mt-12 md:mt-2 pb-24 md:pb-5">
    <div class="flex flex-row flex-wrap flex-grow mt-2">
      <div class="w-full p-3">
        <div class="bg-white border-transparent rounded-lg shadow-lg">
          <div class="p-5">
               <JSCharting :options="options"></JSCharting>
              <button v-on:click="updateData">Update Data</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</template>
<script>
import JSCharting from 'jscharting-vue';

export default {
  
  name: 'Chart',
  data () {
    console.log();
    function toPoints(segment) {
      var points = [{ 
        name: segment.name,
        y: ['2/15/2020', '3/15/2020']
      }]
      if(segment.children){
        points.concat[ segment.children.flatMap(s => [toPoints(s) ]) ]
      }
      return points
    }
    var segments = this.$attrs.project.segments
    var series = segments.flatMap(segment => [
      { 
        
        name: segment.name, 
        points: toPoints(segment)
      }
    ])

    return {
      props: ['segments'],
      options: {
        debug: true,
        /*Typical Gantt setup. Horizontal columns by default.*/
        type: 'horizontal column',
        /*Make columns overlap.*/
        zAxisScaleType: 'stacked',
        /*Time Y Axis.*/
        yAxis_scale_type: 'time',
        legend_position: 'bottom',
        title_label_text:
          'Project Beta from %min to %max',
        
        yAxis: {
          markers: [
            {
              value: '4/20/2020',
              color: '#b0be5f',
              label_text: 'Meeting'
            },
            {
              value: ['3/1/2020', '3/30/2020'],
              color: ['orange', 0.5],
              label_text: 'Vacation'
            }
          ]
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
        
        series: series
        
      },
    }
  },
  created (){
        console.log(this.props)
  },
  components: {
    JSCharting
  }
}
</script>
