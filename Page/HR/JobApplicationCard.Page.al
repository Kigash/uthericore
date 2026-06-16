page 50485 "Job Application Card"
{
    // version TL2.0

    PageType = Card;
    SourceTable = 50277;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Recruitment Request No."; Rec."Recruitment Request No.")
                {
                    ApplicationArea = All;
                }
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("National ID/Passport No."; Rec."National ID/Passport No.")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("No. Years of Experience"; Rec."No. Years of Experience")
                {
                    ApplicationArea = All;
                }
                field("Level of Education"; Rec."Level of Education")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(50277),
                              "No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Attachments)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';
                RunObject = page "Document Attachment Details";
                RunPageLink = "No." = field("No.");

            }
        }

    }

    var
        DocAttach: Record "Document Attachment";
        JobApplications: Record "Job Application";
}
