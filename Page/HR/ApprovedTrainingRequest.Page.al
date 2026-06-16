page 50464 "Approved Training Requests"
{
    ApplicationArea = all;
    CardPageID = "Training Requests Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 50234;
    SourceTableView = WHERE(Status = FILTER('Released'));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field("Training Description"; Rec."Training Description")
                {
                    ApplicationArea = All;
                }
                field("Course/Seminar Name"; Rec."Course/Seminar Name")
                {
                    ApplicationArea = All;
                }
                field("Training Institution"; Rec."Training Institution")
                {
                    ApplicationArea = All;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = All;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = All;
                }
                field("Duration Units"; Rec."Duration Units")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field("Cost of Training"; Rec."Cost of Training")
                {
                    ApplicationArea = All;
                }
                field("Total Cost of Training"; Rec."Total Cost of Training")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        CurrPage.EDITABLE(FALSE);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Error(Error000);
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        Error(Error001);
    end;

    var
        Error000: Label 'You cannot create a new record!';
        Error001: Label 'You cannot modify this record!';

}
