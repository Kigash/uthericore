page 50959 "Inventory File Card"
{
    // version TL2.0

    Editable = false;
    PageType = Card;
    SourceTable = "Registry File";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("File No."; Rec."File No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("RegFile Status"; Rec."RegFile Status")
                {
                    ApplicationArea = All;
                    Caption = 'File Status';
                }
                field("File Number"; Rec."File Number")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("File Type"; Rec."File Type")
                {
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Member No2"; Rec."Member No2")
                {
                    ApplicationArea = All;
                    Caption = 'Old Member No.';
                    Visible = true;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Payroll No."; Rec."Payroll No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Member Status2"; Rec."Member Status2")
                {
                    ApplicationArea = All;
                    Caption = 'Member Status';
                    Visible = true;
                }
                field("Member Status"; Rec."Member Status")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'File Status';
                    Visible = false;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                    Caption = 'Branch Location';
                    ShowMandatory = true;
                }
                field("File Location"; Rec."File Location")
                {
                    ApplicationArea = All;
                    Caption = 'File Location/ Box Reference';
                }
                field("Cabinet/Rack No."; Rec."Cabinet/Rack No.")
                {
                    ApplicationArea = All;
                }
                field("Row No."; Rec."Row No.")
                {
                    ApplicationArea = All;
                }
                field("Column No."; Rec."Column No.")
                {
                    ApplicationArea = All;
                }
                field("Pocket No."; Rec."Pocket No.")
                {
                    ApplicationArea = All;
                }
                field(Volume; Rec.Volume)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                }
                field("<Date  File Closed>"; Rec."Date File Closed")
                {
                    ApplicationArea = All;
                    Caption = 'Date  File Closed';
                    Visible = false;
                }
            }
            part(Page; "Registry File Numbers")
            {
                SubPageLink = "No." = FIELD("File No.");
                Visible = true;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Create File")
            {
                Image = NewDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    RegistryManagement.CreateNewFile(Rec);
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    var
        User: Record "User Setup";
        RegistryFileNumbers: Record "Registry Number";
        FileVolumes: Record "File Volume";
        Selected: Integer;
        MemberExists: Boolean;
        MemberExistsNot: Boolean;
        EditDetails: Boolean;
        RegistryFiles: Record "Registry File";
        //Cust : Record "18";
        RegistryManagement: Codeunit "Registry Management2";
}

