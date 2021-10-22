@extends('layout')
@section('dashboard-content')
    <h1>Create Category Form</h1>

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

    <form action="{{ URL::to('post-category-form')}}" method="post" enctype="multipart/form-data">
        @csrf
        <div class="form-group">
            <label for="categoryName">Category Name</label>
            <input type="text" class="form-control mt-3" id="categoryName" name="categoryName"aria-describedby="emailHelp" placeholder="Enter name">
        </div>

        <div class="form-group">
            <label for="exampleInputEmail1">Category Icon</label>
            <input type="file"  class="form-control" name="categoryIcon" onchange="LoadPhoto(event)">
        </div>
        <div>
            <img id="photo" height="100" width="100">
        </div>
        
        <button type="submit" class="btn btn-primary mt-3">Submit</button>
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