page 50759 "Evaluation Requirement Setup"
{
    PageType = List;
    SourceTable = "Procurement Requirement Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Evaluation Stage"; Rec."Evaluation Stage")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Needs Attachment"; Rec."Needs Attachment")
                {
                    ApplicationArea = All;
                }
                field("Procurement Option"; Rec."Procurement Option")
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
            action("Mandatory Requirements")
            {
                ApplicationArea = All;
                RunObject = Page 50761;
            }
            action("Technical Requirements")
            {
                ApplicationArea = All;
                RunObject = Page 50763;
            }
            action("Financial Requirements")
            {
                ApplicationArea = All;
                RunObject = Page 50762;
            }
        }
    }
}

