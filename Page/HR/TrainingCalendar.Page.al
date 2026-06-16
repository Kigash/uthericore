page 50467 "Training Calendar"
{
    // version TL2.0

    CardPageID = "Training Requests Card";
    Editable = false;
    PageType = List;
    SourceTable = 50234;
    SourceTableView = WHERE(Status = FILTER('Open'), "Added To Calendar" = FILTER('Yes'));
    UsageCategory = Lists;
    ApplicationArea = all;

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
}
