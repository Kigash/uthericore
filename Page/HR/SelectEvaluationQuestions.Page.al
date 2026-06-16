page 50524 "Select Evaluation Questions"
{
    // version TL2.0

    PageType = List;
    SourceTable = 50280;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Training No."; Rec."Training No.")
                {
                    ApplicationArea = All;
                }
                field("Course Name"; Rec."Course Name")
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
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Select Questions")
            {
                RunObject = Page 50523;
                ApplicationArea = All;
                RunPageLink = "Training No." = FIELD("Training No.");
            }
        }
    }
}
