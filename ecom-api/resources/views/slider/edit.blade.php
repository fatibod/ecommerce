@extends('layout')
@section('dashboard-content')
    <h1>Update Slider Form</h1>

    @if (Session::get('success'))
        <div class="alert alert-success alert-dismissible fade show" role="alert" id="gone">
            <strong>{{ (Session::get('success')) }}</strong>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden=true>&times;</span>
            </button>
        </div>
    @endif

    @if (Session::get('failed'))
        <div class="alert alert-warning alert-dismissible fade show" role="alert" id="gone">
            <strong>{{ (Session::get('failed')) }}</strong>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden=true>&times;</span>
            </button>
        </div>
    @endif

    <form action="{{ URL::to('post-slider-edit-form')}}/{{$slider->id}}" method="post" enctype="multipart/form-data">
        @csrf
      
        <div class="form-group">
            <label for="categoryName">Slider title</label>
            <input type="text" class="form-control mt-3" 
            id="exampleInputEmail1"   value="{{$slider->title}}"   name="sliderTitle"aria-describedby="emailHelp" placeholder="Enter name">
        </div>

        <div class="form-group">
            <label for="exampleInputEmail1">Slider message</label>
            <textarea id="editor1" name="sliderMessage">{!!$slider->message!!}</textarea>
        </div>
        <div class="form-group">
            <label for="exampleInputEmail1">Slider Image</label>
            <input type="file"  class="form-control" name="sliderImage" onchange="LoadPhoto(event)">
        </div>

        <div>
            <img id="photo" height="100" width="100">
        </div>
        
        <button type="submit" class="btn btn-primary mt-3">Update</button>
    </form>

    <script>
        function LoadPhoto(event){
            var reader = new FileReader();
            reader.onload = function(){
                var output = document.getElementById('photo');
                output.src = reader.result;
            };
            reader.readAsDataURL(event.target.files[0]);
        }
    </script>
@stop