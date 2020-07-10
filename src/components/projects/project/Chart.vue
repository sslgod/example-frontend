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
    return {
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
            visible: false,
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
        series: [
          {
            name: 'Initiate Project',
            points: [
              {
                name: 'Initiate Project',
                y: ['1/1/2020', '3/15/2020']
              },
              {
                name: 'Project Assignments',
                y: ['1/1/2020', '1/25/2020']
              },
              {
                name: 'Outlines/Scope',
                y: ['1/25/2020', '2/15/2020']
              },
              {
                name: 'Business Alignment',
                y: ['2/15/2020', '3/15/2020']
              }
            ]
          },
          {
            name: 'Plan Project',
            points: [
              {
                name: 'Plan Project',
                y: ['3/15/2020', '5/20/2020']
              },
              {
                name: 'Determine Process',
                y: ['3/15/2020', '4/12/2020']
              },
              {
                name: 'Design Lyouts',
                y: ['4/12/2020', '5/8/2020']
              },
              {
                name: 'Design Structure',
                y: ['5/8/2020', '5/20/2020']
              }
            ]
          },
          {
            name: 'Implement Project',
            points: [
              {
                name: 'Implement Project',
                y: ['5/20/2020', '7/28/2020']
              },
              {
                name: 'Designs',
                y: ['5/20/2020', '6/10/2020']
              },
              {
                name: 'Structures',
                y: ['6/10/2020', '6/15/2020']
              },
              {
                name: 'D&S Integration',
                y: ['6/15/2020', '7/28/2020']
              }
            ]
          },
          {
            name: 'Board Review',
            type: 'marker',
            legendEntry_value: '',
            defaultPoint: {
              tooltip: '%name Meeting Milestone'
            },
            points: [
              {
                name: 'Plan Project',
                y: '5/20/2020'
              },
              {
                name: 'Implement Project',
                y: '7/28/2020'
              }
            ]
          }
        ]
      },
    }
  },
  
  components: {
    JSCharting
  }
}



</script>
