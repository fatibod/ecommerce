@extends('layout')

@section('dashboard-content')


@if (Session::get('deleted'))
    <div class="alert alert-danger alert-dismissible fade show" role="alert" id="gone">
        <strong>{{ (Session::get('deleted')) }}</strong>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden=true>&times;</span>
        </button>
    </div>
@endif

@if (Session::get('delete-failed'))
    <div class="alert alert-warning alert-dismissible fade show" role="alert" id="gone">
        <strong>{{ (Session::get('delete-failed')) }}</strong>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden=true>&times;</span>
        </button>
    </div>
@endif

<div class="card">
    <div class="card-header">
        <i class="fas fa-table"></i>
        Data Table Example
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered table-striped" id="dataTable" width="100%">
                <thead class="thead">
                    <tr>
                    <th scope="col"> Slider title</th>
                    <th scope="col"> Slider message</th>
                    <th scope="col"> Slider image</th>
                    <th scope="col">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                    <th scope="col"> Slider title</th>
                    <th scope="col"> Slider message</th>
                    <th scope="col"> Slider image</th>
                    <th scope="col">Actions</th>

                    </tr>
                </tbody>
                <tbody>
                    @foreach ($sliders as $slider)
                        <tr>
                            <td>{{$slider->title}}</td>
                            <td>{{$slider->message}}</td>

                            <td><img src="{{$slider->icon}}" width="100" height="100"></td>
                            <td>
                                <a href="{{ URL::to('edit-slider') }}/{{$slider->id}}" class="btn btn-success">Edit</a>
                                |
                                <a href="{{ URL::to('delete-slider') }}/{{$slider->id}}" class="btn btn-danger" onclick="return checkDelete()">Delete</a>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>
</div>
    
<script>
    function checkDelete(){
        var check = confirm("Are you sure you want to delete this?");
        if(check){
            return true;
        }
        return false;
    }
</script>

@stop